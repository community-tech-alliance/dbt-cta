{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}

{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    unique_key="_cta_sync_rowid"
)}}

-- Final base SQL model
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`autosend_status` AS STRING) AS `autosend_status`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`limit_assignment_to_teams` AS BOOLEAN) AS `limit_assignment_to_teams`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`title` AS STRING) AS `title`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `autosend_status`,
                                        `id`,
                                        `limit_assignment_to_teams`,
                                        `organization_id`,
                                        `title`))) AS _unique_row_id
FROM {{ source('cta', 'assignable_campaigns_raw') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
            