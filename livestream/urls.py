from django.urls import path
from livestream.views import livestream, PeopleWeCanLivestream, NewConversation, Directs, SendDirect, LoadMore, UserSearch, Broadcast

urlpatterns = [
    path('', livestream, name='livestream'),
    path('start/', PeopleWeCanLivestream, name='people-we-can-livestream'),
    path('broadcast/', Broadcast, name='broadcast_l'),
    path('new/<username>', NewConversation, name='new-conversation_l'),
    path('directs/<username>', Directs, name='directs_l'),
    path('send/', SendDirect, name='send-direct_l'),
    path('loadmore/', LoadMore, name='loadmore_l'),
    path('search/', UserSearch, name='user-search_l'),

]