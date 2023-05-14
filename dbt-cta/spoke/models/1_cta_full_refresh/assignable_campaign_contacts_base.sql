
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
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`contact_timezone` AS STRING) AS `contact_timezone`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`message_status` AS STRING) AS `message_status`,
    CAST(`texting_hours_end` AS INTEGER) AS `texting_hours_end`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `campaign_id`,
                                        `contact_timezone`,
                                        `id`,
                                        `message_status`,
                                        `texting_hours_end`))) AS _cta_hashid
FROM {{ source('cta', 'assignable_campaign_contacts_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}