import { invoke } from "@tauri-apps/api/core";
import { beforeEach, describe, expect, it, vi } from "vitest";

import { useChatStore } from "../../stores/chatStore";
import type {
  GeneratedDocument,
  GenerationMetadata,
  HealthStatus,
  Message,
  Session,
} from "../../types";

const invokeMock = vi.mocked(invoke);
const baseState = useChatStore.getState();

function resetStore() {
  useChatStore.setState(
    {
      ...baseState,
      sessions: [],
      templates: [],
      currentSessionId: null,
      messages: [],
      isStreaming: false,
      streamingContent: "",
      streamError: null,
      searchQuery: null,
      searchResults: null,
      documents: [],
      isGenerating: false,
      generateProgress: null,
      documentsStale: false,
      showPreview: false,
      planReadiness: null,
      planningCoverage: null,
      generationConfidence: null,
      generationMetadata: null,
      latestImportSummary: null,
      toast: null,
      healthStatus: null,
      onboardingDismissed: false,
      wizardCompleted: false,
      wizardStep: "welcome",
      modelPullProgress: null,
      isModelPulling: false,
      installedModels: [],
      isFirstSession: true,
      showSettings: false,
      showHelp: false,
      sidebarCollapsed: false,
      config: null,
      sessionsLoading: false,
      messagesLoading: false,
      preferencesLoaded: false,
      _generatingSessionId: null,
      _unlisteners: [],
    },
    true,
  );
}

describe("workflow smoke", () => {
  beforeEach(() => {
    invokeMock.mockReset();
    resetStore();
  });

  it("supports startup readiness and the session -> chat -> forge -> save flow", async () => {
    const health: HealthStatus = {
      ollama_connected: true,
      ollama_model_available: true,
      database_ok: true,
      config_valid: true,
      errors: [],
    };
    const session: Session = {
      id: "session-1",
      name: "New Project",
      description: null,
      status: "active",
      created_at: "2026-02-22T00:00:00Z",
      updated_at: "2026-02-22T00:00:00Z",
    };
    const userMessage: Message = {
      id: "m-user-1",
      session_id: "session-1",
      role: "user",
      content: "Build a project planner",
      metadata: null,
      created_at: "2026-02-22T00:00:00Z",
    };
    const assistantMessage: Message = {
      id: "m-assistant-1",
      session_id: "session-1",
      role: "assistant",
      content: "Let's define scope first.",
      metadata: null,
      created_at: "2026-02-22T00:00:02Z",
    };
    const docs: GeneratedDocument[] = [
      {
        id: "doc-1",
        session_id: "session-1",
        filename: "SPEC.md",
        content: "# Spec",
        created_at: "2026-02-22T00:01:00Z",
      },
    ];
    const metadata: GenerationMetadata = {
      session_id: "session-1",
      target: "generic",
      provider: "ollama",
      model: "qwen2.5-coder:1.5b",
      run_id: "run-1",
      quality_json: JSON.stringify({
        score: 86,
        missing_must_haves: [],
        missing_should_haves: [],
        summary: "Ready",
      }),
      confidence_json: JSON.stringify({
        score: 84,
        factors: [],
        blocking_gaps: [],
        summary: "High confidence",
      }),
      created_at: "2026-02-22T00:01:05Z",
    };

    invokeMock.mockImplementation(async (command, payload) => {
      switch (command) {
        case "check_health":
          return health;
        case "create_session":
          return session;
        case "send_message":
          return userMessage;
        case "get_messages":
          if ((payload as { session_id: string }).session_id === "session-1") {
            return [userMessage, assistantMessage];
          }
          return [];
        case "get_sessions":
          return [session];
        case "get_planning_coverage":
          return {
            must_have: [],
            should_have: [],
            missing_must_haves: 0,
            missing_should_haves: 0,
            summary: "Covered",
          };
        case "generate_documents":
          return docs;
        case "get_generation_metadata":
          return metadata;
        case "save_to_folder":
          return "/tmp/AuraForge-export";
        default:
          return null;
      }
    });

    const store = useChatStore.getState();
    const healthStatus = await store.checkHealth();
    expect(healthStatus?.database_ok).toBe(true);

    await store.createSession();
    expect(useChatStore.getState().currentSessionId).toBe("session-1");

    await useChatStore.getState().sendMessage("Build a project planner");
    expect(useChatStore.getState().messages).toHaveLength(2);

    const generated = await useChatStore
      .getState()
      .generateDocuments({ target: "generic", force: true });
    expect(generated).toBe(true);
    expect(useChatStore.getState().showPreview).toBe(true);
    expect(useChatStore.getState().documents[0]?.filename).toBe("SPEC.md");

    const savedPath = await useChatStore.getState().saveToFolder("/tmp");
    expect(savedPath).toBe("/tmp/AuraForge-export");

    expect(invokeMock).toHaveBeenCalledWith("create_session", {
      request: { name: null },
    });
    expect(invokeMock).toHaveBeenCalledWith("send_message", {
      request: { session_id: "session-1", content: "Build a project planner" },
    });
    expect(invokeMock).toHaveBeenCalledWith("generate_documents", {
      request: { session_id: "session-1", target: "generic", force: true },
    });
    expect(invokeMock).toHaveBeenCalledWith("save_to_folder", {
      request: { session_id: "session-1", folder_path: "/tmp" },
    });
  });
});
