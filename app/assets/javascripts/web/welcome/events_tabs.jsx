import React from 'react'
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs'

class EventsTabs extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    let tabList = []
    this.props.eventTabs.forEach((tab) => {
      tabList.push(
        <Tab className="tab-title">
          <a>
            {tab.title}
          </a>
        </Tab>
      )
    }) 
    let tabPanels = []
    this.props.eventTabs.forEach((tab) => {
      tabPanels.push(
        <TabPanel>
          <div dangerouslySetInnerHTML={{ __html: tab.html }} />
        </TabPanel>
      )
    })
    return(
      <Tabs selectedTabClassName="active">
        <TabList className="tabs" data-tab="data-tab">
          {tabList}
        </TabList>
        {tabPanels}
      </Tabs>
    )
  }
}

export default EventsTabs
