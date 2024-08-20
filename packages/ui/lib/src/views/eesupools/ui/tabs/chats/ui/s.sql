DECLARE
    eesupool_name TEXT;
    admins_user_id UUID;
    user_fullname TEXT;
BEGIN
    IF NEW.type = 'Invite' THEN
        -- Retrieve the eesupool name from the communities.eesupool table
        SELECT name INTO eesupool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;

        -- Insert a notification into the engagements.notification table
        INSERT INTO engagements.notification(user_id, title, body, data, type)
        VALUES (
            NEW.user_id,
            CONCAT(eesupool_name, ' Invite'),
            CONCAT('You are invited to become a member of ', eesupool_name, '.'),
            jsonb_build_object('user_id', NEW.user_id, 'eesupool_id', NEW.eesupool_id),
            'eesupool_invite'
        );
    ELSE
        -- Retrieve the eesupool name from the communities.eesupool table
        SELECT name INTO eesupool_name FROM communities.eesupool WHERE id = NEW.eesupool_id;

        -- Retrieve the user's full name from the profile table
        SELECT COALESCE(u.corp_name, CONCAT(u.first_name, ' ', u.last_name)) INTO user_fullname
        FROM profile u WHERE u.user_id = NEW.user_id;

        -- Loop through all members of the eesupool and insert notifications
        FOR u IN 
            SELECT m.user_id FROM communities.eesupool_member m WHERE m.eesupool_id = NEW.eesupool_id 
        LOOP
            INSERT INTO engagements.notification(user_id, title, body, data, type)
            VALUES (
                u.user_id,
                CONCAT(eesupool_name, ' Request'),
                CONCAT(user_fullname, ' has requested to join.'),
                jsonb_build_object('user_id', u.user_id, 'eesupool_id', NEW.eesupool_id),
                'eesupool_request'
            );
        END LOOP;
    END IF;

    -- Return the new record
    RETURN NEW;
END;
