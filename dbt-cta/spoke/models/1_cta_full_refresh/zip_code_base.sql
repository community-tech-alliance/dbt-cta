{% set partitions_to_replace = [
            "timestamp_trunc(current_timestamp, day)",
            "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
        ] %}
    
        {{config(
            cluster_by="_cta_sync_datetime_utc",
            partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
            partitions=partitions_to_replace,
            unique_key="zip"
        )}}
    
        -- Final base SQL model
        SELECT
        CAST(`_cta_sync_rowid` AS STRING) AS `_cta_sync_rowid`,
    CAST(`_cta_sync_datetime_utc` AS TIMESTAMP) AS `_cta_sync_datetime_utc`,
    CAST(`city` AS STRING) AS `city`,
    CAST(`has_dst` AS BOOLEAN) AS `has_dst`,
    CAST(`latitude` AS FLOAT64) AS `latitude`,
    CAST(`longitude` AS FLOAT64) AS `longitude`,
    CAST(`state` AS STRING) AS `state`,
    CAST(`timezone_offset` AS FLOAT64) AS `timezone_offset`,
    CAST(`zip` AS INTEGER) AS `zip`,
        FORMAT("%x", FARM_FINGERPRINT(CONCAT(`_cta_sync_rowid`,
                                        `_cta_sync_datetime_utc`,
                                        `city`,
                                        `has_dst`,
                                        `latitude`,
                                        `longitude`,
                                        `state`,
                                        `timezone_offset`,
                                        `zip`))) AS _cta_hashid
    FROM {{ source('cta', 'zip_code_raw') }}
    
    {% if is_incremental() %}
where timestamp_trunc(_cta_sync_datetime_utc, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}