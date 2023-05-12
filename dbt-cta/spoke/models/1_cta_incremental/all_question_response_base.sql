
{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- Final base SQL model
            
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`campaign_contact_id` AS INTEGER) AS `campaign_contact_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`interaction_step_id` AS INTEGER) AS `interaction_step_id`,
    CAST(`is_deleted` AS BOOLEAN) AS `is_deleted`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`value` AS STRING) AS `value`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `campaign_contact_id`,
                                        `created_at`,
                                        `id`,
                                        `interaction_step_id`,
                                        `is_deleted`,
                                        `updated_at`,
                                        `value`))) AS _cta_hashid
FROM {{ source('cta', 'all_question_response_raw') }}
    
    