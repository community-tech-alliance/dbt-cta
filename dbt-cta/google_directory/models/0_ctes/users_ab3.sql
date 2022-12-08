
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(name as 
    string
), ''), '-', coalesce(cast(array_to_string(emails, "|", "") as 
    string
), ''), '-', coalesce(cast(array_to_string(phones, "|", "") as 
    string
), ''), '-', coalesce(cast(array_to_string(aliases, "|", "") as 
    string
), ''), '-', coalesce(cast(isAdmin as 
    string
), ''), '-', coalesce(cast(username as 
    string
), ''), '-', coalesce(cast(array_to_string(relations, "|", "") as 
    string
), ''), '-', coalesce(cast(suspended as 
    string
), ''), '-', coalesce(cast(customerId as 
    string
), ''), '-', coalesce(cast(array_to_string(externalIds, "|", "") as 
    string
), ''), '-', coalesce(cast(orgUnitPath as 
    string
), ''), '-', coalesce(cast(creationTime as 
    string
), ''), '-', coalesce(cast(hashFunction as 
    string
), ''), '-', coalesce(cast(agreedToTerms as 
    string
), ''), '-', coalesce(cast(ipWhitelisted as 
    string
), ''), '-', coalesce(cast(lastLoginTime as 
    string
), ''), '-', coalesce(cast(array_to_string(organizations, "|", "") as 
    string
), ''), '-', coalesce(cast(isMailboxSetup as 
    string
), ''), '-', coalesce(cast(isDelegatedAdmin as 
    string
), ''), '-', coalesce(cast(array_to_string(nonEditableAliases, "|", "") as 
    string
), ''), '-', coalesce(cast(changePasswordAtNextLogin as 
    string
), ''), '-', coalesce(cast(includeInGlobalAddressList as 
    string
), '')) as 
    string
))) as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} tmp
where 1 = 1