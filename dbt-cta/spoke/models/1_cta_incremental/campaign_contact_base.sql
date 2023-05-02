 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`archived` AS BOOLEAN) AS `archived`,
    CAST(`assignment_id` AS INTEGER) AS `assignment_id`,
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`cell` AS INTEGER) AS `cell`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`custom_fields` AS STRING) AS `custom_fields`,
    CAST(`external_id` AS STRING) AS `external_id`,
    CAST(`first_name` AS STRING) AS `first_name`,
    CAST(`first_name_8` AS STRING) AS `first_name_8`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_opted_out` AS BOOLEAN) AS `is_opted_out`,
    CAST(`last_name` AS STRING) AS `last_name`,
    CAST(`message_status` AS STRING) AS `message_status`,
    CAST(`timezone` AS STRING) AS `timezone`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`zip` AS STRING) AS `zip`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `archived`,
                                        `assignment_id`,
                                        `campaign_id`,
                                        `cell`,
                                        `created_at`,
                                        `custom_fields`,
                                        `external_id`,
                                        `first_name`,
                                        `first_name_8`,
                                        `id`,
                                        `is_opted_out`,
                                        `last_name`,
                                        `message_status`,
                                        `timezone`,
                                        `updated_at`,
                                        `zip`))) AS _unique_row_id
    FROM {{ source('cta', 'campaign_contact_raw') }}
    
    