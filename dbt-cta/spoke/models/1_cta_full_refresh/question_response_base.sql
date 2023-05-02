{% set partitions_to_replace = [
            "timestamp_trunc(current_timestamp, day)",
            "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
        ] %}
    
        {{config(
            cluster_by="_cta_sync_datetime_utc",
            partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
            partitions=partitions_to_replace,
            unique_key="id"
        )}}
    
        -- Final base SQL model
        SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`campaign_contact_id` AS INTEGER) AS `campaign_contact_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`interaction_step_id` AS INTEGER) AS `interaction_step_id`,
    CAST(`is_deleted` AS BOOLEAN) AS `is_deleted`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`value` AS STRING) AS `value`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `campaign_contact_id`,
                                        `created_at`,
                                        `id`,
                                        `interaction_step_id`,
                                        `is_deleted`,
                                        `updated_at`,
                                        `value`))) AS _unique_row_id
    FROM {{ source('cta', 'question_response_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}