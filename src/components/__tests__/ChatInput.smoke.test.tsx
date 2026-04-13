import { fireEvent, render, screen } from "@testing-library/react";
import { useState } from "react";
import { describe, expect, it, vi } from "vitest";

import { ChatInput } from "../ChatInput";

function Harness({
  onSend,
  disabled = false,
  isStreaming = false,
}: {
  onSend: (content: string) => void;
  disabled?: boolean;
  isStreaming?: boolean;
}) {
  const [value, setValue] = useState("");
  return (
    <ChatInput
      onSend={onSend}
      disabled={disabled}
      isStreaming={isStreaming}
      value={value}
      onChange={setValue}
    />
  );
}

describe("ChatInput smoke", () => {
  it("renders and sends with Ctrl/Cmd + Enter", () => {
    const onSend = vi.fn();
    render(<Harness onSend={onSend} />);

    const textarea = screen.getByLabelText("Message input");
    fireEvent.change(textarea, { target: { value: "Ship this phase" } });
    fireEvent.keyDown(textarea, { key: "Enter", ctrlKey: true });

    expect(onSend).toHaveBeenCalledWith("Ship this phase");
    expect(onSend).toHaveBeenCalledTimes(1);
  });
});
