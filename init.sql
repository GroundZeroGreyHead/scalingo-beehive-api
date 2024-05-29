DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_user WHERE usename = 'postgres') THEN
    CREATE USER postgres;
    ALTER USER postgres WITH SUPERUSER;
  END IF;
END;
$$ LANGUAGE plpgsql;