
{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- Final base SQL model
            
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`amount` AS INTEGER) AS `amount`,
    CAST(`approved_by_user_id` AS STRING) AS `approved_by_user_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`preferred_team_id` AS INTEGER) AS `preferred_team_id`,
    CAST(`status` AS STRING) AS `status`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`user_id` AS INTEGER) AS `user_id`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `amount`,
                                        `approved_by_user_id`,
                                        `created_at`,
                                        `id`,
                                        `organization_id`,
                                        `preferred_team_id`,
                                        `status`,
                                        `updated_at`,
                                        `user_id`))) AS _cta_hashid
FROM {{ source('cta', 'assignment_request_raw') }}
    
    