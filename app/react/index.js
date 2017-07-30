import RWR, { integrationsManager } from 'react-webpack-rails';
import RWRRedux from 'rwr-redux';

RWR.run();

integrationsManager.register('redux-store', RWRRedux.storeIntegrationWrapper);
integrationsManager.register('redux-container', RWRRedux.containerIntegrationWrapper);

import TagsForm from '../assets/javascripts/web/admin/tags/form'
import CommentsField from '../assets/javascripts/web/comments/field'
import PetitionInputs from '../assets/javascripts/web/members/corporative/petitions/form'
import Vote from '../assets/javascripts/web/shared/vote'
import StandaloneCommentsForm from '../assets/javascripts/web/shared/standalone_comments_form'
import Label from '../assets/javascripts/label'
import EventsTabs from '../assets/javascripts/web/welcome/events_tabs'
RWR.registerComponent('TagsForm', TagsForm)
RWR.registerComponent('CommentsField', CommentsField)
RWR.registerComponent('PetitionInputs', PetitionInputs)
RWR.registerComponent('Vote', Vote)
RWR.registerComponent('StandaloneCommentsForm', StandaloneCommentsForm)
RWR.registerComponent('Label', Label)
RWR.registerComponent('EventsTabs', EventsTabs)
