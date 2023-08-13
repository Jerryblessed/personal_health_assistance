    # SUBJECT URLS #

    # /home/
    path(
         route='subjects/list',
        view=SubjectListView.as_view(),
        name='subject_list'
    ),
     path(
        route='subject/<str:slug>/reps',
        view=SubjectRepsListView.as_view(),
        name='subject_reps'
    ),

    # /subject/<str:slug>/
    path(
        route='@<str:username>/<str:slug>/',
        view=SubjectDetailView.as_view(),
        name='subject_detail'

    ),

    # /search/?q=query/
    path(
        route='subject/search/',
        view=SubjectSearchListView.as_view(),
        name='subject_search_list_view'

     ),

    # /tag/<str:tag_name>/
    path(
        route='tag/<str:tag_name>/subjects',
        view=TagSubjectsListView.as_view(),
        name="tag_subjects"
    ),
