{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('vendors_ab3') }}
select
    CurrencyRef,
    Vendor1099,
    FamilyName,
    TaxIdentifier,
    GivenName,
    CompanyName,
    MetaData,
    DisplayName,
    PrimaryEmailAddr,
    AcctNum,
    WebAddr,
    BillAddr,
    PrimaryPhone,
    PrintOnCheckName,
    airbyte_cursor,
    Title,
    MiddleName,
    Mobile,
    SyncToken,
    Active,
    Suffix,
    domain,
    TermRef,
    Id,
    Fax,
    Balance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_vendors_hashid
from {{ ref('vendors_ab3') }}
-- vendors from {{ source('cta', '_airbyte_raw_vendors') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}