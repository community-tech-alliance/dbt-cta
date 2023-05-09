 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`answer_actions` AS STRING) AS `answer_actions`,
    CAST(`answer_option` AS STRING) AS `answer_option`,
    CAST(`campaign_id` AS INTEGER) AS `campaign_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_deleted` AS BOOLEAN) AS `is_deleted`,
    CAST(`parent_interaction_id` AS INTEGER) AS `parent_interaction_id`,
    CAST(`question` AS STRING) AS `question`,
    CAST(`script_options` AS STRING) AS `script_options`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `answer_actions`,
                                        `answer_option`,
                                        `campaign_id`,
                                        `created_at`,
                                        `id`,
                                        `is_deleted`,
                                        `parent_interaction_id`,
                                        `question`,
                                        `script_options`,
                                        `updated_at`))) AS _cta_hashid
    FROM {{ source('cta', 'interaction_step_raw') }}
    
    