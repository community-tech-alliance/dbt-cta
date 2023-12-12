{% raw %}
{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_{% endraw %}{{ table }}{% raw %}_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('{% endraw %}{{ table }}{% raw %}_ab1') }}{% endraw %}
select * except (_airbyte_raw_id)
from {% raw %}{{ ref('{% endraw %}{{ table }}{% raw %}_ab1') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
{% endraw %}