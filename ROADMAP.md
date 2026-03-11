# Roadmap

## Current Focus

- Keep the extension compliant with Chrome Web Store and Edge Add-ons requirements.
- Keep sync local-first and localhost-only for the current release line.
- Minimize attack surface in the extension and companion app.
- Maintain a stable cross-browser experience on Chrome, Edge, Brave, Vivaldi, and Opera.

## Near Term

- Finish documentation cleanup so README, privacy docs, and release notes match current behavior.
- Add lightweight CI checks for the extension scripts and Node 24 dev server.
- Tighten localhost companion authentication so only the extension can control the local config API.
- Improve release packaging consistency for Windows, macOS, and Linux.

## Planned

- Add a cloud-backed sync mode as an optional future transport.
- Evaluate a WebRTC relay mode for direct browser-to-browser sync where practical.
- Design a transport abstraction so local companion sync, cloud sync, and relay sync can share the same message model.
- Add Chromebook-friendly sync options that do not depend on a native companion app.

## Not Yet Committed

- Native Messaging rewrite.
- ChromeOS native companion support.
- Non-localhost remote companion support.
