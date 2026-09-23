# ota_protocol

Shorebird-compatible OTA check/events protocol types for Meta Code Push.

Shared request/response models for patch check, patch lifecycle events, and
admin/control-plane records — so clients and servers speak the same JSON shape.

## Install

```yaml
dependencies:
  ota_protocol: ^0.1.1
```

## Usage

```dart
import 'package:ota_protocol/ota_protocol.dart';

final request = PatchCheckRequest(
  appId: 'app_xxx',
  channel: 'stable',
  releaseVersion: '1.0.0+1',
  platform: 'ios',
  arch: 'aarch64',
  clientId: 'device-uuid',
);

final json = request.toJson();
final parsed = PatchCheckRequest.fromJson(json);
```

Also exports `PatchCheckResponse` / `PatchArtifact`, `PatchEvent` /
`PatchEventType`, and admin models such as `AppRecord`, `ReleaseRecord`, and
related types.

## License

MIT
