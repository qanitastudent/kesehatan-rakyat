create extension if not exists "pgcrypto";

create table users (
    id uuid primary key default gen_random_uuid(),
    email text unique,
    full_name text,
    phone text,
    created_at timestamptz default now()
);

create table facilities (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    type text not null, -- rumah_sakit, puskesmas, apotek
    address text,
    lat double precision,
    lng double precision,
    source text,
    verified boolean default false,
    created_at timestamptz default now()
);

create table facility_hours (
    id uuid primary key default gen_random_uuid(),
    facility_id uuid references facilities(id),
    day_of_week smallint,
    open_time time,
    close_time time,
    note text
);

create table screenings (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references users(id),
    symptoms jsonb,
    ai_result jsonb,
    severity text,
    created_at timestamptz default now()
);
