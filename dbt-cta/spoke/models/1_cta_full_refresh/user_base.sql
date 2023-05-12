
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
    CAST(`assigned_cell` AS STRING) AS `assigned_cell`,
    CAST(`auth0_id` AS STRING) AS `auth0_id`,
    CAST(`cell` AS STRING) AS `cell`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`email` AS STRING) AS `email`,
    CAST(`first_name` AS STRING) AS `first_name`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_superadmin` AS BOOLEAN) AS `is_superadmin`,
    CAST(`is_suspended` AS BOOLEAN) AS `is_suspended`,
    CAST(`last_name` AS STRING) AS `last_name`,
    CAST(`notification_frequency` AS STRING) AS `notification_frequency`,
    CAST(`terms` AS BOOLEAN) AS `terms`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `assigned_cell`,
                                        `auth0_id`,
                                        `cell`,
                                        `created_at`,
                                        `email`,
                                        `first_name`,
                                        `id`,
                                        `is_superadmin`,
                                        `is_suspended`,
                                        `last_name`,
                                        `notification_frequency`,
                                        `terms`,
                                        `updated_at`))) AS _cta_hashid
FROM {{ source('cta', 'user_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}