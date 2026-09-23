/// Device → server patch check (Shorebird updater compatible).
class PatchCheckRequest {
  const PatchCheckRequest({
    required this.appId,
    required this.channel,
    required this.releaseVersion,
    required this.platform,
    required this.arch,
    required this.clientId,
    this.currentPatchNumber,
  });

  final String appId;
  final String channel;
  final String releaseVersion;
  final String platform;
  final String arch;
  final String clientId;
  final int? currentPatchNumber;

  factory PatchCheckRequest.fromJson(Map<String, dynamic> json) {
    return PatchCheckRequest(
      appId: json['app_id'] as String,
      channel: json['channel'] as String? ?? 'stable',
      releaseVersion: json['release_version'] as String,
      platform: json['platform'] as String,
      arch: json['arch'] as String,
      clientId: json['client_id'] as String,
      currentPatchNumber: json['current_patch_number'] as int? ??
          json['patch_number'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'app_id': appId,
        'channel': channel,
        'release_version': releaseVersion,
        'platform': platform,
        'arch': arch,
        'client_id': clientId,
        if (currentPatchNumber != null)
          'current_patch_number': currentPatchNumber,
      };
}

class PatchArtifact {
  const PatchArtifact({
    required this.number,
    required this.hash,
    required this.downloadUrl,
    this.hashSignature,
    this.uniqueIds,
    this.resourceNumber,
    this.configFingerprint,
    this.hasResourceChanges,
  });

  final int number;
  final String hash;
  final String downloadUrl;
  final String? hashSignature;

  /// Device allowlist. Empty / omitted → all devices may download.
  /// Non-empty → **clients** should only download if their id is listed.
  final List<String>? uniqueIds;

  /// Control-plane resource pack number owned by this patch.
  final int? resourceNumber;

  /// Fingerprint of the full resource inventory for this patch.
  final String? configFingerprint;

  /// Whether this patch's resource table has any add/update/remove entries.
  final bool? hasResourceChanges;

  factory PatchArtifact.fromJson(Map<String, dynamic> json) {
    final rawIds = json['unique_ids'];
    List<String>? uniqueIds;
    if (rawIds is List) {
      uniqueIds = rawIds.map((e) => '$e').where((s) => s.isNotEmpty).toList();
    }
    return PatchArtifact(
      number: json['number'] as int,
      hash: json['hash'] as String,
      downloadUrl: json['download_url'] as String,
      hashSignature: json['hash_signature'] as String?,
      uniqueIds: uniqueIds,
      resourceNumber: (json['resource_number'] as num?)?.toInt(),
      configFingerprint: json['config_fingerprint'] as String?,
      hasResourceChanges: json['has_resource_changes'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'hash': hash,
        'download_url': downloadUrl,
        if (hashSignature != null) 'hash_signature': hashSignature,
        if (uniqueIds != null) 'unique_ids': uniqueIds,
        if (resourceNumber != null) 'resource_number': resourceNumber,
        if (configFingerprint != null) 'config_fingerprint': configFingerprint,
        if (hasResourceChanges != null)
          'has_resource_changes': hasResourceChanges,
      };
}

class PatchCheckResponse {
  const PatchCheckResponse({
    required this.patchAvailable,
    this.patch,
    this.rolledBackPatchNumbers,
  });

  final bool patchAvailable;
  final PatchArtifact? patch;
  final List<int>? rolledBackPatchNumbers;

  factory PatchCheckResponse.fromJson(Map<String, dynamic> json) {
    return PatchCheckResponse(
      patchAvailable: json['patch_available'] as bool? ?? false,
      patch: json['patch'] == null
          ? null
          : PatchArtifact.fromJson(
              Map<String, dynamic>.from(json['patch'] as Map),
            ),
      rolledBackPatchNumbers: (json['rolled_back_patch_numbers'] as List?)
          ?.map((e) => e as int)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'patch_available': patchAvailable,
        if (patch != null) 'patch': patch!.toJson(),
        if (rolledBackPatchNumbers != null)
          'rolled_back_patch_numbers': rolledBackPatchNumbers,
      };

  static const none = PatchCheckResponse(patchAvailable: false);
}
