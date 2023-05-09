 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`request_status` AS STRING) AS `request_status`,
    CAST(`role` AS STRING) AS `role`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`user_id` AS INTEGER) AS `user_id`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `id`,
                                        `organization_id`,
                                        `request_status`,
                                        `role`,
                                        `updated_at`,
                                        `user_id`))) AS _cta_hashid
    FROM {{ source('cta', 'user_organization_raw') }}
    
    