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
    CAST(`answer_actions` AS STRING) AS `answer_actions`,
    CAST(`answer_option` AS STRING) AS `answer_option`,
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_deleted` AS BOOLEAN) AS `is_deleted`,
    CAST(`parent_interaction_id` AS INTEGER) AS `parent_interaction_id`,
    CAST(`question` AS STRING) AS `question`,
    CAST(`script_options` AS STRING) AS `script_options`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `answer_actions`,
                                        `answer_option`,
                                        `campaign_id`,
                                        `created_at`,
                                        `id`,
                                        `is_deleted`,
                                        `parent_interaction_id`,
                                        `question`,
                                        `script_options`,
                                        `updated_at`))) AS _unique_row_id
FROM {{ source('cta', 'interaction_step_raw') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
            