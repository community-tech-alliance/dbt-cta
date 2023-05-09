 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`author_id` AS INTEGER) AS `author_id`,
    CAST(`background_color` AS STRING) AS `background_color`,
    CAST(`confirmation_steps` AS STRING) AS `confirmation_steps`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`deleted_at` AS TIMESTAMP) AS `deleted_at`,
    CAST(`description` AS STRING) AS `description`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_assignable` AS BOOLEAN) AS `is_assignable`,
    CAST(`is_system` AS BOOLEAN) AS `is_system`,
    CAST(`on_apply_script` AS STRING) AS `on_apply_script`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`text_color` AS STRING) AS `text_color`,
    CAST(`title` AS STRING) AS `title`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`webhook_url` AS STRING) AS `webhook_url`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `author_id`,
                                        `background_color`,
                                        `confirmation_steps`,
                                        `created_at`,
                                        `deleted_at`,
                                        `description`,
                                        `id`,
                                        `is_assignable`,
                                        `is_system`,
                                        `on_apply_script`,
                                        `organization_id`,
                                        `text_color`,
                                        `title`,
                                        `updated_at`,
                                        `webhook_url`))) AS _cta_hashid
    FROM {{ source('cta', 'all_tag_raw') }}
    
    