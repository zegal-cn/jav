import React from 'react';
import { Layout, Menu, Icon } from 'antd';
import styles from './MainLayout.less';

function MainLayout({ children, location }) {
  const { Header, Content, Footer, Sider } = Layout;
  const SubMenu = Menu.SubMenu;
  return (
    <Layout style={{ minHeight: '100vh' }}>
      <Sider collapsible>
        <div className={styles.logo}>
          <i className="iconfont icon-qjd-1" />
          <div className={styles.title}>仟金顶运营支撑系统</div>
        </div>
        <Menu
          theme="dark"
          defaultSelectedKeys={[location.pathname]}
          defaultOpenKeys={['sub1']}
          mode="inline"
        >
          <SubMenu
            key="sub1"
            title={
              <span>
                <Icon type="contacts" />
                <span>客户关系管理</span>
              </span>
            }
          >
            <Menu.Item key="3">仪表盘</Menu.Item>
            <Menu.Item key="/users">我的客户</Menu.Item>
            <SubMenu key="sub11" title={<span>储备资源管理</span>}>
              <Menu.Item key="33">储备管理</Menu.Item>
            </SubMenu>
            <Menu.Item key="5">联系人</Menu.Item>
            <Menu.Item key="6">拜访日志</Menu.Item>
            <Menu.Item key="7">问题反馈</Menu.Item>
          </SubMenu>
        </Menu>
      </Sider>
      <Layout>
        <Header className={styles.header}>
          <span className={styles.appTitle}>JAV</span>
        </Header>
        <Content>{children}</Content>
        <Footer style={{ textAlign: 'center' }}>?2017 @zegal</Footer>
      </Layout>
    </Layout>
  );
}

export default MainLayout;
