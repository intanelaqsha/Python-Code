SELECT COUNT(DISTINCT user_Id) AS total_users_downloaded_clips
FROM downloaded_clips;

SELECT COUNT(clips_id) AS total_clips_downloaded
FROM downloaded_clips;

SELECT COUNT(DISTINCT gamesession_Id) AS total_gamesessions_for_downloaded_clips
FROM downloaded_clips;

SELECT COUNT(DISTINCT user_id) AS total_premium_users
FROM premium_users
WHERE STRFTIME('%Y-%m-%d', SUBSTR(starts_at, INSTR(starts_at, '/') + 1)) BETWEEN '2023-09-19' AND '2023-12-19';

SELECT 
    COUNT(DISTINCT user_id) AS total_users_shared_clips,
    COUNT(*) AS total_clips_shared,
    COUNT(DISTINCT gamesession_Id) AS total_gamesessions_shared
FROM shared_clips
WHERE STRFTIME('%Y-%m-%d', SUBSTR(created_at, INSTR(created_at, '/') + 1)) BETWEEN '2023-09-17 9:25:22' AND '2023-12-17  10:14:28';

SELECT 
    strftime('%m-%d-%Y', created_at, 'weekday 0', '-6 days') AS week_start_date,
    COUNT(DISTINCT user_id) AS total_engaged_users,
    COUNT(clip_id) AS total_engaged_clips,
    COUNT(DISTINCT gamesession_id) AS total_engaged_gamesessions
FROM 
    (
        SELECT user_id, clip_id, gamesession_id, created_at
        FROM clips
        UNION ALL
        SELECT user_id, clip_id, gamesession_id, created_at
        FROM shared_clips
        UNION ALL
        SELECT user_id, clip_id, gamesession_id, created_at
        FROM downloaded_clips
    ) AS combined_data
GROUP BY 
    week_start_date;
