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
    CAST(`assignment_priority` AS INTEGER) AS `assignment_priority`,
    CAST(`assignment_type` AS STRING) AS `assignment_type`,
    CAST(`author_id` AS INTEGER) AS `author_id`,
    CAST(`background_color` AS STRING) AS `background_color`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`description` AS STRING) AS `description`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_assignment_enabled` AS BOOLEAN) AS `is_assignment_enabled`,
    CAST(`max_request_count` AS INTEGER) AS `max_request_count`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`text_color` AS STRING) AS `text_color`,
    CAST(`title` AS STRING) AS `title`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `assignment_priority`,
                                        `assignment_type`,
                                        `author_id`,
                                        `background_color`,
                                        `created_at`,
                                        `description`,
                                        `id`,
                                        `is_assignment_enabled`,
                                        `max_request_count`,
                                        `organization_id`,
                                        `text_color`,
                                        `title`,
                                        `updated_at`))) AS _unique_row_id
FROM {{ source('cta', 'team_raw') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
            