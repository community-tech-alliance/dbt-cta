-- CTE:
-- casts fields to data types
-- adds columns `_cta_hashid` and `_cta_sync_datetime_utc`
        
SELECT
    CAST(`tag_id` AS STRING) AS `tag_id`,
    CAST(`lead_id` AS STRING) AS `lead_id`,
    TO_HEX(MD5(CONCAT(`tag_id`,
                      `lead_id`))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{ source('cta', '_lead_tags_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}