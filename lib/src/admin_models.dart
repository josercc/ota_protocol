class AppRecord {
  const AppRecord({
    required this.id,
    required this.name,
    required this.organizationId,
    this.publicKeyPem,
    this.createdAt,
  });

  final String id;
  final String name;
  final String organizationId;
  final String? publicKeyPem;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'organization_id': organizationId,
        'public_key_pem': publicKeyPem,
        'created_at': createdAt?.toIso8601String(),
      };
}

class ReleaseRecord {
  const ReleaseRecord({
    required this.id,
    required this.appId,
    required this.version,
    required this.platform,
    required this.arch,
    this.artifactPath,
    this.createdAt,
  });

  final String id;
  final String appId;
  final String version;
  final String platform;
  final String arch;
  final String? artifactPath;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_id': appId,
        'version': version,
        'platform': platform,
        'arch': arch,
        'artifact_path': artifactPath,
        'created_at': createdAt?.toIso8601String(),
      };
}

class PatchRecord {
  const PatchRecord({
    required this.id,
    required this.appId,
    required this.releaseVersion,
    required this.platform,
    required this.arch,
    required this.number,
    required this.hash,
    required this.channel,
    required this.rolloutPercent,
    required this.rolledBack,
    required this.paused,
    this.hashSignature,
    this.artifactPath,
    this.notes,
    this.changedResources,
    this.resourceNumber,
    this.uniqueIds,
    this.createdAt,
  });

  final String id;
  final String appId;
  final String releaseVersion;
  final String platform;
  final String arch;
  final int number;
  final String hash;
  final String? hashSignature;
  final String channel;
  final int rolloutPercent;
  final bool rolledBack;
  final bool paused;
  final String? artifactPath;
  final String? notes;
  /// Asset changes bundled with this patch (`add` / `update` / `remove`).
  final List<Map<String, dynamic>>? changedResources;
  /// [ResourceRecord.number] this patch was built against, if any.
  final int? resourceNumber;
  /// Device allowlist (`client_id`). Empty/null = all devices.
  final List<String>? uniqueIds;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_id': appId,
        'release_version': releaseVersion,
        'platform': platform,
        'arch': arch,
        'number': number,
        'hash': hash,
        'hash_signature': hashSignature,
        'channel': channel,
        'rollout_percent': rolloutPercent,
        'rolled_back': rolledBack,
        'paused': paused,
        'artifact_path': artifactPath,
        'notes': notes,
        'changed_resources': changedResources,
        'resource_number': resourceNumber,
        'unique_ids': uniqueIds,
        'created_at': createdAt?.toIso8601String(),
      };
}

/// Version-scoped Flutter asset config (mirrors [PatchRecord] lifecycle).
///
/// One published revision per `(app_id, release_version)`; artifact is the
/// JSON resource config file (same shape as `meta_ota scan-assets` output).
class ResourceRecord {
  const ResourceRecord({
    required this.id,
    required this.appId,
    required this.releaseVersion,
    required this.number,
    required this.hash,
    required this.channel,
    required this.rolledBack,
    required this.artifactPath,
    this.sizeBytes,
    this.resourceCount,
    this.notes,
    this.createdAt,
  });

  final String id;
  final String appId;
  final String releaseVersion;
  final int number;
  final String hash;
  final String channel;
  final bool rolledBack;
  final String artifactPath;
  final int? sizeBytes;
  final int? resourceCount;
  final String? notes;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_id': appId,
        'release_version': releaseVersion,
        'number': number,
        'hash': hash,
        'channel': channel,
        'rolled_back': rolledBack,
        'artifact_path': artifactPath,
        'size_bytes': sizeBytes,
        'resource_count': resourceCount,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
      };
}

/// Version-scoped OTA eligibility snapshot (mirrors [ResourceRecord] lifecycle).
///
/// Artifact is the JSON from `meta_ota check-ota` (`meta_ota_snapshot.json`).
class SnapshotRecord {
  const SnapshotRecord({
    required this.id,
    required this.appId,
    required this.releaseVersion,
    required this.number,
    required this.hash,
    required this.channel,
    required this.rolledBack,
    required this.artifactPath,
    this.sizeBytes,
    this.fileCount,
    this.notes,
    this.createdAt,
  });

  final String id;
  final String appId;
  final String releaseVersion;
  final int number;
  final String hash;
  final String channel;
  final bool rolledBack;
  final String artifactPath;
  final int? sizeBytes;
  final int? fileCount;
  final String? notes;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'app_id': appId,
        'release_version': releaseVersion,
        'number': number,
        'hash': hash,
        'channel': channel,
        'rolled_back': rolledBack,
        'artifact_path': artifactPath,
        'size_bytes': sizeBytes,
        'file_count': fileCount,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
      };
}
