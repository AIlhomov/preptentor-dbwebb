--
-- Resets the database to its original state.
--

source setup.sql;

use rymd;

source ddl.sql;
source insert.sql;

CALL show_rymd_with_days();
