
{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
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
    CAST(`applied_escalation_tags` AS STRING) AS `applied_escalation_tags`,
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`contact_timezone` AS STRING) AS `contact_timezone`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`message_status` AS STRING) AS `message_status`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `applied_escalation_tags`,
                                        `campaign_id`,
                                        `contact_timezone`,
                                        `id`,
                                        `message_status`))) AS _cta_hashid
FROM {{ source('cta', 'assignable_campaign_contacts_with_escalation_tags_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}