 # encoding: UTF-8
module ApplicationHelper
  def page_title
    static_pages = {"announcement" => 'Анонс', 'about_myself' => 'О себе', 'billboard' => 'Афиша', 'photos' => 'Фотографии', 'video_records' => 'Видеозаписи', 'reviews' => 'Рецензии', 'side_notes' => 'Заметки на полях', 'links' => 'Ссылки'}
    dinamic_pages = {'songs' => 'Репертуар', 'disks' => 'Дискография', 'feedbacks' => 'Гостевая', 'messages' => 'Контакты'}
    static_pages[params[:id]] || dinamic_pages[params[:controller]]
  end
end