
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
    CAST(`campaign_contact_id` AS INTEGER) AS `campaign_contact_id`,
    CAST(`campaign_variable_ids` AS STRING) AS `campaign_variable_ids`,
    CAST(`contact_number` AS INTEGER) AS `contact_number`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`error_codes` AS STRING) AS `error_codes`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`is_from_contact` AS BOOLEAN) AS `is_from_contact`,
    CAST(`num_media` AS INTEGER) AS `num_media`,
    CAST(`num_segments` AS INTEGER) AS `num_segments`,
    CAST(`queued_at` AS TIMESTAMP) AS `queued_at`,
    CAST(`script_version_hash` AS STRING) AS `script_version_hash`,
    CAST(`send_before` AS TIMESTAMP) AS `send_before`,
    CAST(`send_status` AS STRING) AS `send_status`,
    CAST(`sent_at` AS TIMESTAMP) AS `sent_at`,
    CAST(`service` AS STRING) AS `service`,
    CAST(`service_id` AS STRING) AS `service_id`,
    CAST(`service_response` AS STRING) AS `service_response`,
    CAST(`service_response_at` AS TIMESTAMP) AS `service_response_at`,
    CAST(`text` AS STRING) AS `text`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`user_id` AS INTEGER) AS `user_id`,
    CAST(`user_number` AS INTEGER) AS `user_number`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `assignment_id`,
                                        `campaign_contact_id`,
                                        `campaign_variable_ids`,
                                        `contact_number`,
                                        `created_at`,
                                        `error_codes`,
                                        `id`,
                                        `is_from_contact`,
                                        `num_media`,
                                        `num_segments`,
                                        `queued_at`,
                                        `script_version_hash`,
                                        `send_before`,
                                        `send_status`,
                                        `sent_at`,
                                        `service`,
                                        `service_id`,
                                        `service_response`,
                                        `service_response_at`,
                                        `text`,
                                        `updated_at`,
                                        `user_id`,
                                        `user_number`))) AS _cta_hashid
FROM {{ source('cta', 'message_raw') }}
    
    