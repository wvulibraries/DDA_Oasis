module FormHelper
  def user_role?
    return 'Faculty' if session['cas']['extra_attributes']['isFaculty'] == 'TRUE'
    return 'Staff' if session['cas']['extra_attributes']['isEmployee'] == 'TRUE'
    return 'Undergrad' if session['cas']['extra_attributes']['isStudent'] == 'TRUE'
    return 'Other'
  end
end