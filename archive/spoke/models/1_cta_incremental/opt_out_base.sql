
{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- Final base SQL model
            
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`assignment_id` AS INTEGER) AS `assignment_id`,
    CAST(`cell` AS INTEGER) AS `cell`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`reason_code` AS STRING) AS `reason_code`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `assignment_id`,
                                        `cell`,
                                        `created_at`,
                                        `id`,
                                        `organization_id`,
                                        `reason_code`,
                                        `updated_at`))) AS _cta_hashid
FROM {{ source('cta', 'opt_out_raw') }}
    
    