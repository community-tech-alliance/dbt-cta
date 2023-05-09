 {{ config(
            cluster_by = "updated_at",
            partition_by = {"field": "updated_at", "data_type": "timestamp", "granularity": "day"},
            unique_key = 'campaign_contact_id'
        ) }}

            -- Final base SQL model
            SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`campaign_contact_id` AS INTEGER) AS `campaign_contact_id`,
    CAST(`created_at` AS TIMESTAMP) AS `created_at`,
    CAST(`tag_id` AS INTEGER) AS `tag_id`,
    CAST(`tagger_id` AS INTEGER) AS `tagger_id`,
    CAST(`updated_at` AS TIMESTAMP) AS `updated_at`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `campaign_contact_id`,
                                        `created_at`,
                                        `tag_id`,
                                        `tagger_id`,
                                        `updated_at`))) AS _cta_hashid
    FROM {{ source('cta', 'campaign_contact_tag_raw') }}
    
    