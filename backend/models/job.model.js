const mongoose = require('mongoose');

const jobSchema = new mongoose.Schema({
  title: {
    type: String,
    required: [true, 'Job title is required']
  },
  company: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Company',
    required: true
  },
  location: {
    type: String,
    required: true
  },
  type: {
    type: String,
    enum: ['full-time', 'part-time', 'contract', 'internship'],
    required: true
  },
  description: {
    type: String,
    required: true
  },
  requirements: [{
    type: String
  }],
  salary: {
    min: Number,
    max: Number,
    currency: {
      type: String,
      default: 'USD'
    }
  },
  skills: [{
    type: String
  }],
  experience: {
    min: Number,
    max: Number
  },
  status: {
    type: String,
    enum: ['open', 'closed', 'draft'],
    default: 'open'
  },
  applicationDeadline: Date
}, {
  timestamps: true
});

// Add text index for search functionality
jobSchema.index({ 
  title: 'text', 
  description: 'text',
  skills: 'text'
});

module.exports = mongoose.model('Job', jobSchema);
