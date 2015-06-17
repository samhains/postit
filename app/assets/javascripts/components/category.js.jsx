class Category extends React.Component {
  render(){
    return (
        <span className="badge">
         <a href={"/categories/"+this.props.id}> {this.props.name} </a>
        </span>

      );
  }

}