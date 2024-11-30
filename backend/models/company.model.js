const mongoose = require('mongoose');

const companySchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Company name is required'],
    unique: true
  },
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  description: {
    type: String,
    required: true
  },
  industry: {
    type: String,
    required: true
  },
  website: String,
  logo: String,
  size: {
    type: String,
    enum: ['1-10', '11-50', '51-200', '201-500', '501-1000', '1000+']
  },
  location: {
    type: String,
    required: true
  },
  founded: Number,
  socialMedia: {
    linkedin: String,
    twitter: String,
    facebook: String
  },
  contactEmail: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['active', 'inactive', 'pending'],
    default: 'pending'
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('Company', companySchema);
