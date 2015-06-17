var CheckBoxCategory = React.createClass({
  handleChange: function(e){
    this.props.onUserInput(this.props.category.name, e.target.checked);
  },
  render: function(){
    return (<input type="checkbox" checked={this.props.checked}  
      onChange={this.handleChange}>{this.props.category.name}</input>)
  }
});

var SubmitButton = React.createClass({
  submit: function(){
    $.ajax({
      url: this.props.url,
      
    });
  },
  render: function(){
    return (<button onClick={this.submit}>Submit Categories</button>)
  }
});

var CheckBox = React.createClass({
  getCategoryStateObj: function(){
    
    var allCategories = this.props.categories.reduce(function(obj, val, index){
      obj[val.name] = false;
      return obj
    }, {});

    this.props.currentCategories.forEach(function(category){
      allCategories[category.name] = true;
    });    
    return allCategories
  },
  getInitialState: function(){
    return this.getCategoryStateObj();
    //get from Database the current categories the user belongs to
  },
  handleUserInput: function(name, val){ 
    //this.setState({ [name] :val});

  },
  render: function(){
    var createCategoryBox = (category) => {return <CheckBoxCategory onUserInput={this.handleUserInput} checked={this.state[category.name]} category={category}/>}
    return <div> {this.props.categories.map(createCategoryBox)}</div>;
  }
});