import React from 'react';
import { Button, Modal, Progress } from 'antd';

export default class FreshModal extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = { visible: false };
    this.total = 100;
    this.current = 0;
  }

  showModelHandler = (e) => {
    if (e) e.stopPropagation(); // e.preventDefault();
    this.setState({
      visible: true,
    });
  };

  hideModelHandler = () => {
    this.setState({
      visible: false,
    });
  };

  freshHandler = () => {
    const { onFresh } = this.props;
    onFresh();
  };

  render() {
    const { children, current } = this.props;
    // const { getFieldDecorator } = this.props.form;
    // const { name, email, website } = this.props.record;
    // const formItemLayout = {
    //   labelCol: { span: 6 },
    //   wrapperCol: { span: 14 },
    // };

    return (
      <span>
        <Button icon="cloud-download-o" onClick={this.showModelHandler}>
          {children}
        </Button>
        <Modal
          title="Fresh"
          visible={this.state.visible}
          onOk={this.freshHandler}
          onCancel={this.hideModelHandler}
        >
          <Progress percent={current} />
        </Modal>
      </span>
    );
  }
}
