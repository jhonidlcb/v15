
-- Script para eliminar tablas no utilizadas relacionadas con i18n
-- Ejecutar este script en la base de datos para limpiar tablas innecesarias

-- 1. Eliminar tablas de internacionalización que ya no se usan
DROP TABLE IF EXISTS content_translations CASCADE;
DROP TABLE IF EXISTS i18n_entries CASCADE;
DROP TABLE IF EXISTS user_preferences CASCADE;
DROP TABLE IF EXISTS exchange_rates CASCADE;
DROP TABLE IF EXISTS currencies CASCADE;
DROP TABLE IF EXISTS languages CASCADE;

-- 2. Verificar que las tablas fueron eliminadas
DO $$
DECLARE
    table_count INTEGER;
BEGIN
    -- Contar tablas relacionadas con i18n que aún existan
    SELECT COUNT(*)
    INTO table_count
    FROM information_schema.tables
    WHERE table_schema = 'public'
    AND table_name IN (
        'content_translations',
        'i18n_entries', 
        'user_preferences',
        'exchange_rates',
        'currencies',
        'languages'
    );
    
    IF table_count = 0 THEN
        RAISE NOTICE 'SUCCESS: Todas las tablas de i18n han sido eliminadas correctamente';
    ELSE
        RAISE NOTICE 'WARNING: Aún quedan % tablas de i18n sin eliminar', table_count;
    END IF;
END $$;

-- 3. Mostrar todas las tablas restantes en la base de datos
SELECT 
    table_name as "Tablas Restantes",
    CASE 
        WHEN table_name IN (
            'users', 'partners', 'projects', 'referrals', 'tickets', 
            'payments', 'portfolio', 'notifications', 'project_messages',
            'project_files', 'project_timeline', 'ticket_responses',
            'payment_methods', 'invoices', 'transactions', 'payment_stages',
            'budget_negotiations', 'work_modalities', 'sessions'
        ) THEN 'EN USO'
        ELSE 'REVISAR'
    END as "Estado"
FROM information_schema.tables 
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE'
ORDER BY table_name;
