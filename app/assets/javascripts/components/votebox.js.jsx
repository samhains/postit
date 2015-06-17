
var VoteBox = React.createClass({
  getInitialState(){
    return {
      totalVotes: this.props.total_votes,
      lastVote: this.props.last_vote,
      voted: this.props.last_vote === null ? false : true
    };
  },
  updateVotes(direction){
    direction ? this.setState({totalVotes: this.state.totalVotes+1}) : this.setState({totalVotes:this.state.totalVotes-1});

  },
  handleVote(direction){
    if(this.state.lastVote == direction){
      return;
    }


    $.ajax({
      type: "POST",
      url: this.props.url,
      data: {direction},
      success: (data) => { 
        this.update(direction, data);
      }
    });
  },
  update(direction, data){

    if(data.old_vote){
      //if there is an old vote, reverse it
      var oldVote = data.old_vote.vote;
      this.updateVotes(!oldVote);
    }
    var newVote = data.new_vote.vote;
    
    this.updateVotes(direction);
    this.setState({lastVote: direction, voted: true});
  },
  render (){
    return (
      <div className="well span0 text-center"> 
      <ArrowButton handleVote={this.handleVote} direction={true} voted={this.state.voted} active={this.state.lastVote} />
      <TotalVotes votes={this.state.totalVotes}/>
      <ArrowButton handleVote={this.handleVote} direction={false} voted={this.state.voted} active={!this.state.lastVote}/>
      </div>
      );
  }
});

class ArrowButton extends React.Component{
  handleClick(){
    this.props.handleVote(this.props.direction);

  }
  render(){
    var cx = React.addons.classSet;
     var classes = cx({
        'icon-arrow-up': this.props.direction,
        'icon-arrow-down': !this.props.direction,
        'active-arrow': this.props.voted && this.props.active
      });
    return (
      <i onClick={this.handleClick.bind(this)} className={classes}></i>
      );
  }
}

class TotalVotes extends React.Component{
  render(){
    return (
      <p> {this.props.votes} </p>);
  }
}

