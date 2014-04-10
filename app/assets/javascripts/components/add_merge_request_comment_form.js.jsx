/** @jsx React.DOM */

var AddMergeRequestCommentForm = React.createClass({

  getInitialState: function() {
    return {
      processing:         false,
      error:              false,
      mergeRequestStatus: this.props.currentMergeRequestStatus
    };
  },

  render: function() {
    var error;
    var statusSelect;

    if (this.props.mergeRequestStatuses.length > 0) {
      var options = [<option value=""></option>];
      options = options.concat(cull.map(function(status) {
        return <option value={status}>{status}</option>
      }.bind(this), this.props.mergeRequestStatuses));

      statusSelect =
        <div className="control-group">
          <div className="controls">
            <label className="control-label">State</label>
            <select ref="status" value={this.state.mergeRequestStatus} onChange={this.handleStatusChange}>{options}</select>
          </div>
        </div>;
    }

    if (this.state.error) {
      error = <span className="error">Communication with the server failed. Please try again in a minute.</span>;
    }

    return (
      <div className="gts-new-comment">
        <div className="gts-comment-form">
          <h3>Add comment</h3>
          <MarkdownEditor ref="editor" />
          <div className="row">
            {statusSelect}
            {error}
            <div className="form-actions">
              <button className="btn btn-primary" onClick={this.handleSubmit} disabled={this.state.processing}>Comment</button>
            </div>
          </div>
        </div>
      </div>
    );
  },

  handleStatusChange: function(event) {
    this.setState({ mergeRequestStatus: event.target.value });
  },

  handleSubmit: function(event) {
    event.preventDefault();
    this.setError(false);

    var body = this.refs.editor.getText();

    if (!body.match(/^\s*$/) || this.state.mergeRequestStatus && this.state.mergeRequestStatus !== this.props.currentMergeRequestStatus) {
      this.setProcessing(true);

      var comment = { body: body, state: this.state.mergeRequestStatus };
      var data = { comment: comment, utf8: "✓" };

      var req = $.ajax({
        url:      this.props.url,
        method:   "post",
        dataType: 'json',
        data:     data
      });

      req.done(function(data) {
        this.setProcessing(false);
        this.props.onSuccess(data);
      }.bind(this));

      req.fail(function() {
        this.setProcessing(false);
        this.setError(true);
      }.bind(this));
    }
  },

  setProcessing: function(processing) {
    this.setState({ processing: processing });
  },

  setError: function(error) {
    this.setState({ error: error });
  },

  handleCancel: function(event) {
    event.preventDefault();
    this.props.onClose();
  }

});
