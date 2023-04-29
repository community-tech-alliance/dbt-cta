{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}

{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    unique_key="_cta_sync_rowid"
)}}

-- Final base SQL model
SELECT
    CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`autosend_limit` AS STRING) AS `autosend_limit`,
    CAST(`autosend_limit_max_contact_id` AS STRING) AS `autosend_limit_max_contact_id`,
    CAST(`autosend_status` AS STRING) AS `autosend_status`,
    CAST(`autosend_user_id` AS STRING) AS `autosend_user_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`creator_id` AS INTEGER) AS `creator_id`,
    CAST(`description` AS STRING) AS `description`,
    CAST(`due_by` AS TIMESTAMP) AS `due_by`,
    CAST(`external_system_id` AS STRING) AS `external_system_id`,
    CAST(`id` AS INTEGER) AS `id`,
    CAST(`intro_html` AS STRING) AS `intro_html`,
    CAST(`is_approved` AS BOOLEAN) AS `is_approved`,
    CAST(`is_archived` AS BOOLEAN) AS `is_archived`,
    CAST(`is_autoassign_enabled` AS BOOLEAN) AS `is_autoassign_enabled`,
    CAST(`is_started` AS BOOLEAN) AS `is_started`,
    CAST(`is_template` AS BOOLEAN) AS `is_template`,
    CAST(`landlines_filtered` AS BOOLEAN) AS `landlines_filtered`,
    CAST(`limit_assignment_to_teams` AS BOOLEAN) AS `limit_assignment_to_teams`,
    CAST(`logo_image_url` AS STRING) AS `logo_image_url`,
    CAST(`messaging_service_sid` AS STRING) AS `messaging_service_sid`,
    CAST(`organization_id` AS INTEGER) AS `organization_id`,
    CAST(`primary_color` AS STRING) AS `primary_color`,
    CAST(`replies_stale_after_minutes` AS INTEGER) AS `replies_stale_after_minutes`,
    CAST(`texting_hours_end` AS INTEGER) AS `texting_hours_end`,
    CAST(`texting_hours_start` AS INTEGER) AS `texting_hours_start`,
    CAST(`timezone` AS STRING) AS `timezone`,
    CAST(`title` AS STRING) AS `title`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
    CAST(`use_dynamic_assignment` AS STRING) AS `use_dynamic_assignment`,
    FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `autosend_limit`,
                                        `autosend_limit_max_contact_id`,
                                        `autosend_status`,
                                        `autosend_user_id`,
                                        `created_at`,
                                        `creator_id`,
                                        `description`,
                                        `due_by`,
                                        `external_system_id`,
                                        `id`,
                                        `intro_html`,
                                        `is_approved`,
                                        `is_archived`,
                                        `is_autoassign_enabled`,
                                        `is_started`,
                                        `is_template`,
                                        `landlines_filtered`,
                                        `limit_assignment_to_teams`,
                                        `logo_image_url`,
                                        `messaging_service_sid`,
                                        `organization_id`,
                                        `primary_color`,
                                        `replies_stale_after_minutes`,
                                        `texting_hours_end`,
                                        `texting_hours_start`,
                                        `timezone`,
                                        `title`,
                                        `updated_at`,
                                        `use_dynamic_assignment`))) AS _unique_row_id
FROM {{ source('cta', 'all_campaign_raw') }}

{% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
            