 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`autosending_mps` AS STRING) AS `autosending_mps`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`default_texting_tz` AS STRING) AS `default_texting_tz`,
    CAST(`deleted_at` AS STRING) AS `deleted_at`,
    CAST(`deleted_by` AS STRING) AS `deleted_by`,
    CAST(`features` AS STRING) AS `features`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`monthly_message_limit` AS STRING) AS `monthly_message_limit`,
    CAST(`name` AS STRING) AS `name`,
    CAST(`texting_hours_end` AS INTEGER) AS `texting_hours_end`,
    CAST(`texting_hours_enforced` AS BOOLEAN) AS `texting_hours_enforced`,
    CAST(`texting_hours_start` AS INTEGER) AS `texting_hours_start`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`uuid` AS STRING) AS `uuid`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `autosending_mps`,
                                        `created_at`,
                                        `default_texting_tz`,
                                        `deleted_at`,
                                        `deleted_by`,
                                        `features`,
                                        `id`,
                                        `monthly_message_limit`,
                                        `name`,
                                        `texting_hours_end`,
                                        `texting_hours_enforced`,
                                        `texting_hours_start`,
                                        `updated_at`,
                                        `uuid`))) AS _cta_hashid
    FROM {{ source('cta', 'organization_raw') }}
    
    