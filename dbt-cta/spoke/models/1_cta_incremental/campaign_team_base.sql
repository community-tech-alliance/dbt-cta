
{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- Final base SQL model
            
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`team_id` AS INTEGER) AS `team_id`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `campaign_id`,
                                        `created_at`,
                                        `id`,
                                        `team_id`,
                                        `updated_at`))) AS _cta_hashid
FROM {{ source('cta', 'campaign_team_raw') }}
    
    