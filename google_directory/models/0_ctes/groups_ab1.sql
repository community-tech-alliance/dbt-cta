
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users._airbyte_raw_groups
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['etag']") as etag,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract_scalar(_airbyte_data, "$['name']") as name,
    json_extract_scalar(_airbyte_data, "$['email']") as email,
    json_extract_scalar(_airbyte_data, "$['description']") as description,
    json_extract_scalar(_airbyte_data, "$['adminCreated']") as adminCreated,
    json_extract_scalar(_airbyte_data, "$['directMembersCount']") as directMembersCount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users._airbyte_raw_groups as table_alias
-- groups
where 1 = 1
