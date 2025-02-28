/*
  # Fix library_clues table and policies

  1. Changes
    - Drop existing table completely
    - Create fresh table with proper schema
    - Add public access policies
    - Insert initial data

  2. Security
    - Enable RLS
    - Public read access
    - Public update access for discovered status
*/

-- Drop existing table and all its policies
DROP TABLE IF EXISTS public.library_clues CASCADE;

-- Create the table
CREATE TABLE public.library_clues (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  book_title text NOT NULL,
  page_content text NOT NULL,
  discovered boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.library_clues ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Public read access"
  ON public.library_clues
  FOR SELECT
  TO PUBLIC
  USING (true);

CREATE POLICY "Public update access"
  ON public.library_clues
  FOR UPDATE
  TO PUBLIC
  USING (true)
  WITH CHECK (true);

-- Insert initial data
INSERT INTO public.library_clues (book_title, page_content, discovered) 
VALUES (
  'Venomous Flora',
  'A detailed study of arsenic-laced ferns, with particular attention to their use in Victorian gardens...',
  false
);
