## Openfield

The dbt models in this project deliver typed and normalized data for the following tables from Openfield:

- knock_conversation_code
- knock_people
- redshift_people_attempts
- redshift_people_celloptins_conversations
- redshift_people_email_conversations
- redshift_people_list_conversations
- redshift_people_longtext_conversations
- redshift_people_name_conversations
- redshift_people_shorttext_conversations
- redshift_people_truefalse_conversations

Even though most users only actually use a subset of these tables, the way this project is structured, all tables are delivered, even if they are empty.

Although this dbt project specifies models for delivering materialized views to partners, currently the DAG we use to deliver OpenField data performs that final delivery using PythonOperator instead of dbt. However, the code defining those matviews is included here in `2_partner_matviews` for reference. As in all other dbt projects in this repository, materialized views consist of simple SELECT * queries against the `_base` models in `1_cta_full_refresh` or `1_cta_incremental`.