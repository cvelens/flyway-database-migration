CREATE TABLE IF NOT EXISTS cve.cve (
			id TEXT,
			version INTEGER,
			assigner_org_id TEXT,
			assigner_short_name TEXT,
			date_published TEXT,
			date_reserved TEXT,
			date_updated TEXT,
			state TEXT,
			data JSONB,
			created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (id, version)
		);