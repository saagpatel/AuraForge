# AuraForge .codex command map

| Action        | Command            | Source                                         |
| ------------- | ------------------ | ---------------------------------------------- |
| setup deps    | `npm ci`           | `package-lock.json` convention, `package.json` |
| lint fallback | `npm run build`    | `package.json` (no dedicated lint script)      |
| test          | `npm run test`     | `package.json`, `.codex/actions/test.sh`       |
| build         | `npm run build`    | `package.json`                                 |
| lean dev      | `npm run dev:lean` | `README.md`, `package.json`                    |
