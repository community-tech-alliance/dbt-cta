
{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- Final base SQL model
            
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`hash` AS STRING) AS `hash`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_valid` AS BOOLEAN) AS `is_valid`,
    CAST(`payload` AS STRING) AS `payload`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `created_at`,
                                        `hash`,
                                        `id`,
                                        `is_valid`,
                                        `payload`,
                                        `updated_at`))) AS _cta_hashid
FROM {{ source('cta', 'invite_raw') }}
    
    