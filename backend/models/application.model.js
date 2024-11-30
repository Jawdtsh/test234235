const mongoose = require('mongoose');

const applicationSchema = new mongoose.Schema({
  job: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Job',
    required: true
  },
  applicant: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  resume: {
    type: String,
    required: true
  },
  coverLetter: String,
  status: {
    type: String,
    enum: ['pending', 'reviewed', 'shortlisted', 'rejected', 'accepted'],
    default: 'pending'
  },
  expectedSalary: {
    amount: Number,
    currency: {
      type: String,
      default: 'USD'
    }
  },
  notes: String
}, {
  timestamps: true
});

// Ensure one application per job per user
applicationSchema.index({ job: 1, applicant: 1 }, { unique: true });

module.exports = mongoose.model('Application', applicationSchema);
